lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.999039039039039 --fixed-mass2 53.550910910910915 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020514735.2933837 \
--gps-end-time 1020521935.2933837 \
--d-distr volume \
--min-distance 1128.149855622734e3 --max-distance 1128.169855622734e3 \
--l-distr fixed --longitude 83.52862548828125 --latitude 2.9478671550750732 --i-distr uniform \
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
