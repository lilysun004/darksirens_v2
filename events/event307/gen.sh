lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.277997997997996 --fixed-mass2 16.15131131131131 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000965254.5175661 \
--gps-end-time 1000972454.5175661 \
--d-distr volume \
--min-distance 2621.661417086363e3 --max-distance 2621.6814170863636e3 \
--l-distr fixed --longitude -44.108642578125 --latitude 34.56561279296875 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
