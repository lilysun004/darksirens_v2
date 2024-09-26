lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.37057057057057 --fixed-mass2 58.42546546546547 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016561216.0302278 \
--gps-end-time 1016568416.0302278 \
--d-distr volume \
--min-distance 1259.7795666780185e3 --max-distance 1259.7995666780184e3 \
--l-distr fixed --longitude -40.2886962890625 --latitude 42.191585540771484 --i-distr uniform \
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
